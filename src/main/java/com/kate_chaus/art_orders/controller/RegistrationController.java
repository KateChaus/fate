package com.kate_chaus.art_orders.controller;

import com.kate_chaus.art_orders.domain.User;
import com.kate_chaus.art_orders.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(
            @RequestParam("password2") String passwordConfirm,
            @Valid User user,
            BindingResult bindingResult,
            Model model
    ) {

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);

        if (isConfirmEmpty) {
            model.addAttribute("password2Error", "Подтвердите пароль");
        }

        if (user.getPassword() !=null && !user.getPassword().equals(passwordConfirm))
        {
            model.addAttribute("passwordError", "Пароли не совпадают");

        }
        if (isConfirmEmpty || bindingResult.hasErrors()||!user.getPassword().equals(passwordConfirm)){
            Map<String,String> errors = ControllerUtil.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "registration";
        }
        if (!userService.addUser(user)) {
            model.addAttribute("usernameError", "Пользователь существует");
            return "registration";
        }
        return "redirect:/login";
    }

}
