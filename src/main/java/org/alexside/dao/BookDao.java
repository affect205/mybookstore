package org.alexside.dao;

import org.alexside.entity.Book;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Alex Balyschev
 * Date: 15.12.15
 * Time: 17:48
 * To change this template use File | Settings | File Templates.
 */
public interface BookDao {

    public Integer deleteBook(Book book);
    public Integer addBook(Book book, byte[] bytes);
    public Integer editBook(Book book);
    public List<Book> getBookList();
    public Book getBookById(Long id);

}
