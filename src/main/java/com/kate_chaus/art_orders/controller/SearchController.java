package com.kate_chaus.art_orders.controller;

import com.kate_chaus.art_orders.domain.OrderApplication;
import com.kate_chaus.art_orders.domain.Type;
import com.kate_chaus.art_orders.domain.User;
import com.kate_chaus.art_orders.repos.OrderApplicationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Locale;
import java.util.Set;

@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    OrderApplicationRepo orderApplicationRepo;

    @GetMapping("/")
    public String search(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) Integer cost,
            Model model
    ) {

        Set<OrderApplication> artistApplications;
        Set<OrderApplication> customerApplications;
        if (type != null && !type.equals("none")) {
            Type enumType = Type.valueOf(type.toUpperCase(Locale.ROOT));
            if (cost != null) {
                artistApplications = orderApplicationRepo.findByOpenAndTypeAndCostLessThanEqualAndArtistSearch(true, enumType, cost, true);
                customerApplications = orderApplicationRepo.findByOpenAndTypeAndCostLessThanEqualAndArtistSearch(true, enumType, cost, false);
            } else {
                artistApplications = orderApplicationRepo.findByOpenAndTypeAndArtistSearch(true, enumType,true);
                customerApplications = orderApplicationRepo.findByOpenAndTypeAndArtistSearch(true, enumType,false);
            }
        } else {
            if (cost != null) {
                artistApplications = orderApplicationRepo.findByOpenAndCostLessThanEqualAndArtistSearch(true, cost,true);
                customerApplications = orderApplicationRepo.findByOpenAndCostLessThanEqualAndArtistSearch(true, cost,false);
            } else {
                artistApplications = orderApplicationRepo.findByOpenAndArtistSearch(true, true);
                customerApplications = orderApplicationRepo.findByOpenAndArtistSearch(true, false);
            }
        }

        model.addAttribute("userChannel", currentUser);
        model.addAttribute("artistApplications", artistApplications);
        model.addAttribute("customerApplications", customerApplications);

        return "search";
    }

}
