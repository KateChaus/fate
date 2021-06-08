package com.kate_chaus.art_orders.controller;

import com.kate_chaus.art_orders.domain.Site;
import com.kate_chaus.art_orders.domain.User;
import com.kate_chaus.art_orders.repos.SiteRepo;
import com.kate_chaus.art_orders.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/settings")
public class SettingsController {
    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private SiteRepo siteRepo;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("{user}")
    public String getSettings(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model
    ) {
        model.addAttribute("userChannel", user);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        return "settings";
    }

    @PostMapping("{user}/edit")
    public String setSettings(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("userInfo") String userInfo,
            @RequestParam(value = "password2", required = false) String newPassword,
            @RequestParam(value = "currentPassword", required = false) String currentPassword,
            @PathVariable User user

    ) throws IOException {

        /*if (newPassword != null || !newPassword.equals("")) {
            boolean isConfirmEmpty = StringUtils.isEmpty(newPassword);

            if (!passwordEncoder.encode(currentPassword).equals(user.getPassword())) {
                model.addAttribute("currentPasswordError", "Неверный пароль");
            }

            if (isConfirmEmpty) {
                model.addAttribute("password2Error", "Подтвердите пароль");
            }

            if (user.getPassword() != null && !user.getPassword().equals(newPassword)) {
                model.addAttribute("passwordError", "Пароли не совпадают");

            }
            if (isConfirmEmpty || bindingResult.hasErrors() || !user.getPassword().equals(newPassword) || !passwordEncoder.encode(currentPassword).equals(user.getPassword())) {
                Map<String, String> errors = ControllerUtil.getErrors(bindingResult);
                model.mergeAttributes(errors);
                return "redirect:/settings/" + user.getId();
            }

            user.setPassword(passwordEncoder.encode(newPassword));
        }*/
        if (userInfo != null) {
            user.setUserInfo(userInfo);
        }
        userRepo.save(user);

        return "redirect:/settings/" + user.getId();
    }

    @PostMapping("{user}/avatar")
    public String changeAvatar(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam("image") MultipartFile image
    ) throws IOException {
        saveFile(user, image);
        userRepo.save(user);
        return "redirect:/settings/" + currentUser.getId();

    }

    @PostMapping("{user}/artist")
    public String changeStatus(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam(required = false) String isArtist
    ) throws IOException {
        if (isArtist != null) {
            user.setArtist(true);
        } else {
            user.setArtist(false);
        }
        userRepo.save(user);
        return "redirect:/settings/" + user.getId();
    }

    @PostMapping("{user}/site/add")
    public String addSite(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam String siteName,
            @RequestParam String siteLink
    ) {
        Site site = new Site(siteName, siteLink, currentUser);
        siteRepo.save(site);

        return "redirect:/settings/" + user;

    }

    @PostMapping("{user}/site/delete")
    public String deleteSite(
            @PathVariable Long user,
            @RequestParam Long siteId
    ) {
        siteRepo.deleteById(siteId);
        return "redirect:/settings/" + user;

    }


    private void saveFile(User user, MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/avatars/" + resultFilename));
            user.setAvatar(resultFilename);
        }
    }
}
