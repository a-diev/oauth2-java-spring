package com.adiev;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping("/dashboard")
    public String dashboard(Authentication authentication, HttpServletRequest request, Model model) {
        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();

            if (principal instanceof UserDetails userDetails) {
                model.addAttribute("username", userDetails.getUsername());
                model.addAttribute("authorities", userDetails.getAuthorities());
            } else if (principal instanceof OAuth2User oAuth2User) {
                model.addAttribute("username", oAuth2User.getAttribute("name"));
                model.addAttribute("email", oAuth2User.getAttribute("email"));
                model.addAttribute("authorities", oAuth2User.getAuthorities());
            }
        }

        // Add CSRF Token
        CsrfToken csrf = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
        if (csrf != null) {
            model.addAttribute("csrf", csrf);
        }

        return "pages/dashboard";
    }
}
