package com.library.pojo;

public class Book {
    private int id;
    private String title;
    private String author;
    private int stock;

    public Book() {
    }

    public Book(int id, String title, String author, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.stock = stock;
    }

    // ... existing code ...
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}
// ... existing code ...

