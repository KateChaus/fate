package com.kate_chaus.art_orders.domain;

import javax.persistence.*;

@Entity
public class OrderApplication {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User creator;

    private boolean artistSearch;

    private String name;

    private int cost;

    private String description;

    private boolean open;

    @Enumerated (EnumType.STRING)
    private Type type;

    public OrderApplication() {

    }

    public OrderApplication(User creator, boolean artistSearch, String name, int cost, String description, boolean open, Type type) {
        this.creator = creator;
        this.artistSearch = artistSearch;
        this.name = name;
        this.cost = cost;
        this.description = description;
        this.open = open;
        this.type = type;
    }

    public OrderApplication(Long id, User creator, boolean artistSearch, String name, int cost, String description, boolean open, Type type) {
        this.id = id;
        this.creator = creator;
        this.artistSearch = artistSearch;
        this.name = name;
        this.cost = cost;
        this.description = description;
        this.open = open;
        this.type = type;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public boolean isArtistSearch() {
        return artistSearch;
    }

    public void setArtistSearch(boolean artistSearch) {
        this.artistSearch = artistSearch;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
