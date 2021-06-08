package com.kate_chaus.art_orders.domain;

import javax.persistence.*;

@Entity
@Table(name = "ordr")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "app_id")
    private OrderApplication orderApplication;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "artist_id")
    private User artist;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id")
    private User customer;

    @Enumerated (EnumType.STRING)
    private Status status;

    private String image;

    private int artistRating;
    private int customerRating;

    public Order() {
    }

    public Order(OrderApplication orderApplication, User artist, User customer, Status status, String image, int artistRating, int customerRating) {
        this.orderApplication = orderApplication;
        this.artist = artist;
        this.customer = customer;
        this.status = status;
        this.image = image;
        this.artistRating = artistRating;
        this.customerRating = customerRating;
    }

    public Order(Long id, OrderApplication orderApplication, User artist, User customer, Status status, String image, int artistRating, int customerRating) {
        this.id = id;
        this.orderApplication = orderApplication;
        this.artist = artist;
        this.customer = customer;
        this.status = status;
        this.image = image;
        this.artistRating = artistRating;
        this.customerRating = customerRating;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public OrderApplication getOrderApplication() {
        return orderApplication;
    }

    public void setOrderApplication(OrderApplication orderApplication) {
        this.orderApplication = orderApplication;
    }

    public User getArtist() {
        return artist;
    }

    public void setArtist(User artist) {
        this.artist = artist;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getArtistRating() {
        return artistRating;
    }

    public void setArtistRating(int artistRating) {
        this.artistRating = artistRating;
    }

    public int getCustomerRating() {
        return customerRating;
    }

    public void setCustomerRating(int customerRating) {
        this.customerRating = customerRating;
    }
}
