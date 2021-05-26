package com.chaus.art_orders.repos;

import com.chaus.art_orders.domain.Message;
import org.springframework.data.repository.CrudRepository;

public interface MessageRepo extends CrudRepository<Message,Long>{

}
