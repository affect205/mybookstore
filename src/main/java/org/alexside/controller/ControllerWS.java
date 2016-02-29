package org.alexside.controller;

import org.alexside.entity.Book;
import org.alexside.service.BookService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Alex
 * Date: 03.01.16
 * Time: 1:38
 * To change this template use File | Settings | File Templates.
 */
@RestController
@RequestMapping("/bookstore/ws")
public class ControllerWS {

    Logger LOG = LoggerFactory.getLogger(ControllerWS.class);

    @Autowired
    BookService bookService;

    /**
     * Список книг
     * @param start
     * @param limit
     */
    @RequestMapping(value = "/getBookList", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    public @ResponseBody
    ResponseEntity<String> getBookList(@RequestParam(name = "start", defaultValue = "0") Integer start,
                                       @RequestParam(name = "limit", defaultValue = "50") Integer limit)
            throws Exception {
        LOG.debug(String.format("start: %s limit: %s", start, limit));
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        List<Book> bookList = bookService.getAll();
        for (Book book : bookList) {
            JSONObject joo = new JSONObject();
            joo.put("id", book.id);
            joo.put("name", book.name);
            joo.put("author", book.author);
            joo.put("genre", book.genre);
            joo.put("year", book.year);
            String ref = "";
            if (book.file == null) {
                ref = "";
            } else {
                int size = book.file.length/1024;
                ref = String.format("Скачать (%s Кб)", size < 1 ? 1 : size);
            }
            joo.put("ref", ref);
            ja.add(joo);
        }
        jo.put("data", ja);
        jo.put("msg", String.format("start: %s limit: %s", start, limit));
        jo.put("success", true);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        return new ResponseEntity<String>(jo.toJSONString(), responseHeaders, HttpStatus.CREATED);
    }

    /**
     * Добавление новой книги
     * @param name
     * @param author
     * @param year
     * @param genre
     * @param file
     */
    @RequestMapping(value="/addBook", method=RequestMethod.POST)
    public @ResponseBody ResponseEntity<String> addBook(@RequestParam("name") String name,
                                                        @RequestParam("author") String author,
                                                        @RequestParam("year") Integer year,
                                                        @RequestParam("genre") String genre,
                                                        @RequestParam("file") MultipartFile file){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "application/json; charset=utf-8");
        JSONObject jo = new JSONObject();
        String msg = "";

        if (!file.isEmpty()) {
            String filename = file.getOriginalFilename();
            try {
                byte[] bytes = file.getBytes();
                bookService.add(new Book(name, author, year, genre, filename), bytes);
                LOG.info(msg = "You successfully uploaded " + filename + "!");
                jo.put("log", msg);
                jo.put("success", true);
                return new ResponseEntity<String>(jo.toJSONString(), responseHeaders, HttpStatus.CREATED);
            } catch (Exception e) {
                LOG.info(msg = "You failed to upload " + filename + " => " + e.getMessage());
                jo.put("log", msg);
                jo.put("success", false);
                return new ResponseEntity<String>(jo.toJSONString(), responseHeaders, HttpStatus.CREATED);
            }
        } else {
            LOG.info(msg = "You failed to upload " + name + " because the file was empty.");
            jo.put("msg", msg);
            jo.put("success", false);
            return new ResponseEntity<String>(jo.toJSONString(), responseHeaders, HttpStatus.CREATED);
        }
    }

    /**
     * Загрузка файла с книгой
     * @param bookId
     */
    @RequestMapping(value="/file/{id}", method=RequestMethod.GET)
    public ResponseEntity<?> downloadBook(@PathVariable("id") String bookId) {
        HttpHeaders responseHeaders = new HttpHeaders();
        try {
            Book book = bookService.getById(Long.parseLong(bookId));
            byte[] file = book.file;
            ByteArrayInputStream bais = new ByteArrayInputStream(file);
            responseHeaders.setContentType(new MediaType("application", "octet-stream"));
            responseHeaders.setContentLength(file.length);
            String filename = String.valueOf(Math.abs(book.name.hashCode()));
            int ndx = book.filename.lastIndexOf(".");
            String ext = ndx > -1 ? book.filename.substring(ndx) : "";
            responseHeaders.setContentDispositionFormData("attachment", filename + ext);
            InputStreamResource isr = new InputStreamResource(bais);
            return new ResponseEntity<InputStreamResource>(isr, responseHeaders, HttpStatus.OK);
        } catch(Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    /**
     * Получение книги по id
     * @param bookId
     */
    @RequestMapping(value="/getBookById", method=RequestMethod.POST)
    public ResponseEntity<String> getBookById(@RequestParam(name = "id", defaultValue = "null") Long bookId) {
        HttpHeaders responseHeaders = new HttpHeaders();
        JSONObject jo = new JSONObject();
        try {
            if (bookId == null) throw new Exception("Не задан идентификатор книги");
            Book book = bookService.getById(bookId);
            jo.put("id", book.id);
            jo.put("name", book.name);
            jo.put("description", book.description);
            jo.put("genre", book.genre);
            jo.put("author", book.author);
            jo.put("filename", book.filename);
            jo.put("success", true);
            return new ResponseEntity<String>(jo.toJSONString(), responseHeaders, HttpStatus.OK);
        } catch(Exception e) {
            jo.put("msg", e.getMessage());
            jo.put("success", false);
            return new ResponseEntity<String>(jo.toJSONString(), responseHeaders, HttpStatus.CREATED);
        }
    }

}