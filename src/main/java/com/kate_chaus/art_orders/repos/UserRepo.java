package com.kate_chaus.art_orders.repos;

import com.kate_chaus.art_orders.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String username);


}
