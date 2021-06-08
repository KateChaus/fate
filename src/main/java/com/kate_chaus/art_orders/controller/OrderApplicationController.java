package com.kate_chaus.art_orders.controller;

import com.kate_chaus.art_orders.domain.*;
import com.kate_chaus.art_orders.repos.OrderApplicationRepo;
import com.kate_chaus.art_orders.repos.OrderRepo;
import com.kate_chaus.art_orders.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@Controller
@RequestMapping("/orders")
public class OrderApplicationController {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private OrderApplicationRepo orderApplicationRepo;

    @Autowired
    private OrderRepo orderRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("{user}/artist")
    public String getArtistOrders(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            Model model) {

        model.addAttribute("userChannel", currentUser);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        Set<OrderApplication> applications = orderApplicationRepo.findByArtistSearchAndCreator(false, currentUser);
        model.addAttribute("applications", applications);
        Set<Order> inProcess = orderRepo.findByArtistAndStatus(currentUser, Status.PROCESS);
        inProcess.addAll(orderRepo.findByArtistAndStatus(currentUser, Status.COMPLETED));

        model.addAttribute("inProcess", inProcess);
        Set<Order> confirmed = orderRepo.findByArtistAndStatus(currentUser, Status.CONFIRMED);
        model.addAttribute("confirmed", confirmed);
        model.addAttribute("artistSearch", "false");
        return "orders";
    }

    @PostMapping("{user}/order")
    public String changeOrderStatus(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam(required = false) String statusChange,
            @RequestParam(required = false) String edit,
            @RequestParam(required = false) String delete,
            @RequestParam OrderApplication orderApplication,
            Model model
    ) {
        if (statusChange != null) {
            orderApplication.setOpen(!orderApplication.isOpen());
            orderApplicationRepo.save(orderApplication);
        }

        if (edit != null) {
            return "redirect:/orders/edit/" + orderApplication.getId();
        }

        if (delete != null) {
            orderApplicationRepo.delete(orderApplication);
        }
        return "redirect:/orders/" + currentUser.getId() + "/artist";
    }

    @GetMapping("edit/{orderApplication}")
    public String getApplication(
            @AuthenticationPrincipal User currentUser,
            @PathVariable OrderApplication orderApplication,
            Model model
    ) {
        model.addAttribute("userChannel", currentUser);
        model.addAttribute("application", orderApplication);
        return "edit";
    }

    @PostMapping("edit/{orderApplication}")
    public String editApplication(
            @AuthenticationPrincipal User currentUser,
            @PathVariable OrderApplication orderApplication,
            @RequestParam String name,
            @RequestParam String description
    ) {
        orderApplication.setName(name);
        orderApplication.setDescription(description);
        orderApplicationRepo.save(orderApplication);

        return "redirect:/orders/" + currentUser.getId() + "/artist";
    }

    @GetMapping("{user}/customer")
    public String getCustomerOrders(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            Model model) {
        model.addAttribute("userChannel", currentUser);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        Set<OrderApplication> applications = orderApplicationRepo.findByArtistSearchAndCreator(true, currentUser);
        model.addAttribute("applications", applications);
        Set<Order> inProcess = orderRepo.findByCustomerAndStatus(currentUser, Status.PROCESS);
        inProcess.addAll(orderRepo.findByCustomerAndStatus(currentUser, Status.COMPLETED));
        model.addAttribute("inProcess", inProcess);
        Set<Order> confirmed = orderRepo.findByCustomerAndStatus(currentUser, Status.CONFIRMED);
        model.addAttribute("confirmed", confirmed);
        model.addAttribute("artistSearch", "true");
        return "orders";
    }

    @GetMapping("{user}/artist/new")
    public String newArtistApplicationForm(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model) {

        model.addAttribute("userChannel", user);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("artistSearch", "false");
        return "application";
    }

    @GetMapping("{user}/customer/new")
    public String newCustomerApplicationForm(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model) {

        model.addAttribute("userChannel", user);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("artistSearch", "true");
        return "application";
    }

    @PostMapping("{user}/artist/new")
    public String newArtistApplication(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam boolean artistSearch,
            @RequestParam String name,
            @RequestParam int cost,
            @RequestParam String type,
            @RequestParam String description
    ) {

        Type enumType = Type.valueOf(type.toUpperCase(Locale.ROOT));

        OrderApplication orderApplication = new OrderApplication(currentUser, artistSearch, name, cost, description, true, enumType);
        orderApplicationRepo.save(orderApplication);

        return "redirect:/orders/" + currentUser.getId() + "/artist";
    }

    @PostMapping("{user}/customer/new")
    public String newCustomerApplication(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam boolean artistSearch,
            @RequestParam String name,
            @RequestParam int cost,
            @RequestParam String type,
            @RequestParam String description
    ) {

        Type enumType = Type.valueOf(type.toUpperCase(Locale.ROOT));

        OrderApplication orderApplication = new OrderApplication(currentUser, artistSearch, name, cost, description, true, enumType);
        orderApplicationRepo.save(orderApplication);

        return "redirect:/orders/" + currentUser.getId() + "/customer";
    }

    @PostMapping("{orderApplication}/apply")
    public String apply(
            @AuthenticationPrincipal User currentUser,
            @RequestParam boolean artistSearch,
            @RequestParam OrderApplication application

    ) {
        String image = "default.png";
        Order order;
        if (artistSearch) {
            order = new Order(application, currentUser, application.getCreator(), Status.PROCESS, image,5,5);
            orderRepo.save(order);
            return "redirect:/orders/" + currentUser.getId() + "/artist";
        } else {
            order = new Order(application, application.getCreator(), currentUser, Status.PROCESS, image,5,5);
            orderRepo.save(order);
            return "redirect:/orders/" + currentUser.getId() + "/customer";
        }
    }

    @PostMapping("/update/{order}")
    public String Update(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Order order,
            @RequestParam(value = "image", required = false) MultipartFile image,
            @RequestParam(required = false) String status,
            @RequestParam int rate,
            @RequestParam boolean artistSearch
    ) throws IOException {
        if (status != null) {
            Status enumStatus = Status.valueOf(status.toUpperCase(Locale.ROOT));
            if (enumStatus.equals(Status.PROCESS)){
                order.setStatus(Status.COMPLETED);
                order.setCustomerRating(rate);
                System.out.println(order.getStatus());
            }
            else{
                order.setArtistRating(rate);
                order.setStatus(Status.CONFIRMED);
            }
        }

        if (image != null && !image.isEmpty()) {
            saveFile(order, image);
            order.setStatus(Status.PROCESS);
        }

        orderRepo.save(order);
        if(artistSearch){
            return "redirect:/orders/" + currentUser.getId() + "/customer";
        }
        else {
            return "redirect:/orders/" + currentUser.getId() + "/artist";
        }
    }


    private void saveFile(Order order, MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/arts/" + resultFilename));
            order.setImage(resultFilename);
        }
    }
}
