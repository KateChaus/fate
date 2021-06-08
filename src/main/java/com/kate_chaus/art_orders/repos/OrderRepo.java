package com.kate_chaus.art_orders.repos;

import com.kate_chaus.art_orders.domain.Order;
import com.kate_chaus.art_orders.domain.Status;
import com.kate_chaus.art_orders.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Set;

public interface OrderRepo extends CrudRepository<Order, Long> {

    Set<Order> findByArtistAndStatus(User artist, Status status);
    Set<Order> findByCustomerAndStatus(User customer, Status status);
    Set<Order> findByStatus(Status status);
    Set<Order> findTop3ByArtistAndStatusOrderByIdDesc(User artist, Status status);
    Set<Order> findTop3ByCustomerAndStatusOrderByIdDesc(User customer, Status status);
}
