package com.kate_chaus.art_orders.repos;

import com.kate_chaus.art_orders.domain.OrderApplication;
import com.kate_chaus.art_orders.domain.Type;
import com.kate_chaus.art_orders.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Set;

public interface OrderApplicationRepo extends CrudRepository<OrderApplication, Long> {
    Set<OrderApplication> findByArtistSearchAndCreator(boolean artistSearch, User creator);
    Set<OrderApplication> findByOpenAndArtistSearch(boolean isOpen, boolean artistSearch);
    Set<OrderApplication> findByType(Type type);
    Set<OrderApplication> findByOpenAndTypeAndArtistSearch(boolean isOpen, Type type, boolean artisSearch);
    Set<OrderApplication> findByOpenAndTypeAndCostLessThanEqualAndArtistSearch(boolean isOpen, Type type, int cost, boolean artistSearch);
    Set<OrderApplication> findByOpenAndCostLessThanEqualAndArtistSearch(boolean isOpen, int cost, boolean artistSearch);
}
