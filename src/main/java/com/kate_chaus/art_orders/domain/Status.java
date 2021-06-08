package com.kate_chaus.art_orders.domain;

public enum Status {
    PROCESS("В процессе"),
    COMPLETED("Исполнен"),
    CONFIRMED("Подтвержён");

    private final String name;

    private Status(String s) {
        name = s;
    }

    public String toString() {
        return this.name;
    }
}
