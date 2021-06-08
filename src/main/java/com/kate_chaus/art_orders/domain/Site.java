package com.kate_chaus.art_orders.domain;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Site {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Отсутствует название сайта")
    private String siteName;
    @NotBlank(message = "Нет ссылки")
    private String siteAddress;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User owner;

    public Site() {
    }

    public Site(String siteName, String siteAddress, User owner) {
        this.siteName = siteName;
        this.siteAddress = siteAddress;
        this.owner = owner;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public String getSiteAddress() {
        return siteAddress;
    }

    public void setSiteAddress(String siteAddress) {
        this.siteAddress = siteAddress;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }
}
