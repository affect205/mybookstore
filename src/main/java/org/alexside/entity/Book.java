package org.alexside.entity;

/**
 * Created with IntelliJ IDEA.
 * User: Alex Balyschev
 * Date: 15.12.15
 * Time: 17:51
 * Сущность книги
 */
import org.springframework.util.StringUtils;

import javax.persistence.*;
import java.sql.Blob;

@Entity
@Table(name = "book")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    // Название
    @Basic(fetch = FetchType.EAGER)
    @Column(name = "name", nullable = false)
    public String name;

    // Автор
    @Basic(fetch = FetchType.EAGER)
    @Column(name = "author", nullable = false)
    public String author;

    // Год выпуска
    @Basic(fetch = FetchType.EAGER)
    @Column(name = "year", nullable = false)
    public Integer year;

    // Описание
    @Basic(fetch = FetchType.EAGER)
    @Column(name = "description", nullable = false)
    public String description;

    // Жанр
    @Basic(fetch = FetchType.EAGER)
    @Column(name = "genre", nullable = false)
    public String genre;

    // Имя файла
    @Basic(fetch = FetchType.EAGER)
    @Column(name = "filename", nullable = false)
    public String filename;

    // Файл
    @Basic(fetch = FetchType.LAZY)
    @Column(name = "file", nullable = false)
    @Lob
    //public Blob file;
    public byte[] file;

    public Book() {}

    public Book(String name, String author, Integer year, String genre, String filename) {
        this.name = name;
        this.author = author;
        this.year = year;
        this.genre = genre;
        this.filename = filename;
    }

    public Book(String name, String author, Integer year, String genre, String filename, byte[] file) {
        this.name = name;
        this.author = author;
        this.year = year;
        this.genre = genre;
        this.filename = filename;
        this.file = file;
    }

    public Long getId() {
        return id;
    }

    public String getAuthor() {
        return this.author;
    }

    public String getName() {
        return this.name;
    }

    public Integer getYear() {
        return this.year;
    }

    public String getGenre() {
        return this.genre;
    }

    public String getFilename() {
        return StringUtils.isEmpty(this.filename) ? "" : this.filename;
    }

    public String getDescription() {
        return StringUtils.isEmpty(this.description) ? "" : this.description;
    }
}