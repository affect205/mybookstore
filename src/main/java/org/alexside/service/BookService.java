package org.alexside.service;

import org.alexside.dao.BookDao;
import org.alexside.dao.BookDaoImpl;
import org.alexside.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Author: Alexey Balyschev
 * Date: 15.12.15
 */
@Service
public class BookService {

    @Autowired
    private BookDao bookDao;

    @Transactional
    public void add(Book book, byte[] bytes) {
        bookDao.addBook(book, bytes);
    }

    @Transactional
    public void delete(Book book) {
        bookDao.deleteBook(book);
    }

    @Transactional
    public void edit(Book book) {
        bookDao.editBook(book);
    }

    @Transactional
    public List<Book> getAll() {
        return bookDao.getBookList();
    }

    @Transactional
    public Book getById(Long id) {
        return bookDao.getBookById(id);
    }
}
