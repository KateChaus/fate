package com.kate_chaus.art_orders.controller;

import com.kate_chaus.art_orders.domain.Order;
import com.kate_chaus.art_orders.domain.Status;
import com.kate_chaus.art_orders.domain.User;
import com.kate_chaus.art_orders.repos.OrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Set;

@Controller
public class MainController {

    @Autowired
    private OrderRepo orderRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String main(
            @AuthenticationPrincipal User user,
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model
    ) {
        Set<Order> orders = orderRepo.findByStatus(Status.CONFIRMED);
        model.addAttribute("user",user);
        model.addAttribute("orders", orders);

        return "main";
    }

}

