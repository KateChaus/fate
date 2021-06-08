package com.kate_chaus.art_orders.domain;


public enum Type {
    TRADITIONAL ("2D (Традиционный)"),
    DIGITAL ("2D (Цифровой)"),
    THREEDIMENSIONAL ("3D"),
    ANIMATION ("Aнимация"),
    OTHER ("Другое");

    private final String name;

    private Type(String s) {
        name = s;
    }

    public String toString() {
        return this.name;
    }
}
