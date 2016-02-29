package org.alexside.controller;

import org.alexside.bean.TestBean;
import org.alexside.entity.Book;
import org.alexside.service.BookService;
import org.alexside.util.SomeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Author: Alexey Balyschev
 * Date: 13.12.15
 */
@org.springframework.stereotype.Controller
@RequestMapping("/bookstore")
public class ControllerUrl {

    Logger LOG = LoggerFactory.getLogger(ControllerUrl.class);

    @Autowired
    BookService bookService;

    String[] CLASS_PATH_ARR = new String[] {"../applicationContext.xml", "../database-config.xml"};

    /**
     * Главная страница
     */
    @RequestMapping(value = {"/hello", ""}, method = RequestMethod.GET)
    public String getIndexPage(ModelMap model) {

        ApplicationContext appContext = new ClassPathXmlApplicationContext(CLASS_PATH_ARR);
        TestBean testBean = (TestBean) appContext.getBean("testBean");
        System.out.println(String.format("Test bean value is %s", testBean.msg));

        model.addAttribute("message", "Онлайн-библиотека Bookstore!");
        model.addAttribute("bookList", bookService.getAll());
        return "hello";
    }

    /**
     * Страница просмотра книги
     */
    @RequestMapping(value = "/edit/{id}" ,method = RequestMethod.GET)
     public String getBookPage(@PathVariable("id") String bookId,
                               ModelMap model) {
        model.addAttribute("message", "Онлайн-библиотека Bookstore!");
        model.addAttribute("menu", "Редактирование");
        Book book = bookService.getById(Long.parseLong(bookId));
        SomeUtils.LOG(String.format("id: %s, name: %s, author: %s, year: %s", book.id, book.name, book.author, book.year));
        model.addAttribute("book", book);
        return "editbook";
    }

    /**
     * Перенеправление
     * @param model
     */
    @RequestMapping(value = {"/hello2", "/hello3"}, method = {RequestMethod.GET, RequestMethod.POST},
            headers = "User-Agent: Android")
    public ModelAndView sayHello2(ModelMap model) {
        model.addAttribute("message", "Spring 4 MVC Hello World 2");
        return new ModelAndView("hello", model);
    }
}
