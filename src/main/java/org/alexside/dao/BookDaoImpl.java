package org.alexside.dao;

import org.alexside.entity.Book;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Alex Balyschev
 * Date: 15.12.15
 * Time: 17:47
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class BookDaoImpl implements BookDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Integer deleteBook(Book book) {
        return 0;
    }

    @Override
    public Integer addBook(Book book, byte[] bytes) {
        try {
            Session session = sessionFactory.getCurrentSession();
            //Blob file = Hibernate.getLobCreator(session).createBlob(bytes);
            //book.file = file;
            book.file = bytes;
            session.saveOrUpdate(book);
            session.flush();
            return 1;

        } catch(Exception e) {
            return -1;
        }
    }

    @Override
    public Integer editBook(Book book) {
        return 0;
    }

    @Override
    public List<Book> getBookList() {

        List<Book> result = new ArrayList<Book>();
        try {
            Session session = sessionFactory.getCurrentSession();
            result = session.createQuery("select b from Book b order by b.year").list();
            return result;

        } catch(Exception e) {
            return result;
        }
    }

    @Override
    public Book getBookById(Long id) {

        Book book = null;
        try {
            Session session = sessionFactory.getCurrentSession();
            book = (Book)session.createQuery("select b from Book b where b.id = :id").setLong("id", id).uniqueResult();
            return book;

        } catch(Exception e) {
            return book;
        }
    }
}
