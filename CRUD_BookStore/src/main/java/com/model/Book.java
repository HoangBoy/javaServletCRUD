package com.model;


public class Book {
    protected String id;
    protected String title;
    protected String author;
    protected float price;
 
    public Book() {
    }
 
    public Book(String id) {
        this.id = id;
    }
 

     
    public Book(String id, String title, String author, float price) {
    	this.id = id;
        this.title = title;
        this.author = author;
        this.price = price;
      
    }
 
    

	public String getId() {
        return id;
    }
 
    public void setId(String id) {
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
 
    public float getPrice() {
        return price;
    }
 
    public void setPrice(float price) {
        this.price = price;
    }
}
