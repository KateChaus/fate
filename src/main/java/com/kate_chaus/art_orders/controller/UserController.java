package com.kate_chaus.art_orders.controller;

import com.kate_chaus.art_orders.domain.Order;
import com.kate_chaus.art_orders.domain.Site;
import com.kate_chaus.art_orders.domain.Status;
import com.kate_chaus.art_orders.domain.User;
import com.kate_chaus.art_orders.repos.OrderRepo;
import com.kate_chaus.art_orders.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private OrderRepo orderRepo;

    @GetMapping("subscribe/{user}")
    public String subscribe(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user
    ) {
        userService.subscribe(currentUser, user);

        return "redirect:/user/" + user.getId() + "/profile";
    }

    @GetMapping("unsubscribe/{user}")
    public String unsubscribe(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user
    ) {
        userService.unsubscribe(currentUser, user);

        return "redirect:/user/" + user.getId() + "/profile";
    }

    @GetMapping("{type}/{user}/list")
    public String userList(
            Model model,
            @PathVariable User user,
            @PathVariable String type
    ) {
        model.addAttribute("userChannel", user);
        model.addAttribute("type", type);

        if ("subscriptions".equals(type)) {
            model.addAttribute("users", user.getSubscriptions());
        } else {
            model.addAttribute("users", user.getSubscribers());
        }
        return "subscriptions";

    }

    @GetMapping("{user}/profile")
    public String profile(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model
    ) {
        Set<Order> artistOrders = orderRepo.findByArtistAndStatus(user, Status.CONFIRMED);
        Set<Order> customerOrders = orderRepo.findByCustomerAndStatus(user, Status.CONFIRMED);

        float artistRate = 0;
        if(!artistOrders.isEmpty()) {
            for (Order order : artistOrders) {
                artistRate += order.getArtistRating();
            }
            artistRate = artistRate / artistOrders.size();
        }

        float customerRate = 0;
        if(!customerOrders.isEmpty()) {
            for (Order order : customerOrders) {
                customerRate += order.getCustomerRating();

            }
            customerRate = customerRate / customerOrders.size();
        }

        Set<Order> recentOrdersArtist = orderRepo.findTop3ByArtistAndStatusOrderByIdDesc(user,Status.CONFIRMED);
        Set<Order> recentOrdersCustomer = orderRepo.findTop3ByCustomerAndStatusOrderByIdDesc(user,Status.CONFIRMED);

        Set<Site> sites = user.getSites();
        Set<User> subscribers = user.getSubscribers();
        Set<User> subscriptions = user.getSubscriptions();
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userChannel", user);
        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));
        model.addAttribute("subscribers", subscribers.size());
        model.addAttribute("subscriptions", subscriptions.size());
        model.addAttribute("artistRate",artistRate);
        model.addAttribute("customerRate",customerRate);
        if(!sites.isEmpty()) {
            model.addAttribute("sites", sites);
        }
        model.addAttribute("recentOrdersArtist",recentOrdersArtist);
        model.addAttribute("recentOrdersCustomer",recentOrdersCustomer);

        return "profile";
    }

    @GetMapping("{user}/profile/orderList")
    public String getOrders(
            @PathVariable User user,
            Model model
    ){
        Set<Order> orders = orderRepo.findByArtistAndStatus(user,Status.CONFIRMED);
        model.addAttribute("orders",orders);
        model.addAttribute("customer",false);
        return "orderList";
    }

    @GetMapping("{user}/profile/customerList")
    public String getCustomerOrders(
            @PathVariable User user,
            Model model
    ){
        Set<Order> orders = orderRepo.findByCustomerAndStatus(user,Status.CONFIRMED);
        model.addAttribute("orders",orders);
        model.addAttribute("customer", true);
        return "orderList";
    }

    @GetMapping("subscriptions/{user}")
        public String getSubscriptions(
                @PathVariable User user,
                Model model
    ){
            Set<User> subscribers = user.getSubscribers();
            Set<User> subscriptions = user.getSubscriptions();
            model.addAttribute("subscribers",subscribers);
            model.addAttribute("subscriptions",subscriptions);
            return "subscriptions";
    }

}
