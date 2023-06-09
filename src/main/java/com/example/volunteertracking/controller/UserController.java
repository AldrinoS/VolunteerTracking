package com.example.volunteertracking.controller;

import com.example.volunteertracking.config.ApiAuthenticationEntryPoint;
import com.example.volunteertracking.config.JwtUtil;
import com.example.volunteertracking.model.LoginRequest;
import com.example.volunteertracking.model.Volunteer;
import com.example.volunteertracking.service.UserDetailsImpl;
import com.example.volunteertracking.service.VolunteerService;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    VolunteerService volunteerService;

    @Autowired
    JwtUtil jwtUtil;

    @Autowired
    AuthenticationManager authenticationManager;

    @GetMapping("/health")
    public String healthCheck() {
        return "Service is UP";
    }

    @GetMapping("registerUser")
    public RedirectView registerUser(@RequestParam String name, @RequestParam String number, @RequestParam String location,
                               @RequestParam String date, RedirectAttributes attributes) throws Exception {

        UUID uuid = UUID.randomUUID();
        Volunteer volunteer = new Volunteer();
        volunteer.setName(name);
        volunteer.setDate(date);
        volunteer.setLocation(location);
        volunteer.setNumber(number);
        volunteer.setPassword(uuid.toString());

        try {
            volunteerService.saveUser(volunteer);
        } catch (Exception e) {
            attributes.addFlashAttribute("registerFailed", "User with given contact number already exists!");
            return new RedirectView("/register");
//            return new ResponseEntity("User with given contact number already exists", HttpStatus.INTERNAL_SERVER_ERROR);
        }
//        logger.info("Register New User Done");
//        model.addAttribute("password", uuid.toString());
//        RedirectView redirectView = new RedirectView("/login");
//        redirectView.fl("password", uuid.toString());
//        redirectView.setExposeModelAttributes(true); // optional
        attributes.addFlashAttribute("password", uuid.toString());
        return new RedirectView("/login");
//        return "login.jsp";
    }

    @GetMapping("/loginRedirect")
    public RedirectView redirectLogin(RedirectAttributes attributes) {
        attributes.addFlashAttribute("password", "1234");
        return new RedirectView("/login");
    }

    @PostMapping("registerUser")
    public RedirectView postRegisterUser(@RequestBody Volunteer volunteer, RedirectAttributes attributes) throws Exception {

        try {
            volunteerService.saveUser(volunteer);
        } catch (Exception e) {
            logger.info("Register Error Occurred");
            throw e;
//            return new ResponseEntity("User with given contact number already exists", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        attributes.addFlashAttribute("password", volunteer.getPassword());
        return new RedirectView("/login");
//        return "login.jsp";
    }

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {

        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(loginRequest.getNumber(), loginRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResponseCookie jwtCookie = jwtUtil.generateJwtCookie(userDetails);
        ResponseCookie authUser = ResponseCookie.from("User", userDetails.getNumber())
                .path("/")
                .maxAge(1 * 24 * 60 * 60)
                .domain("localhost")
                .build();
        logger.info("JWT: " + jwtCookie.toString());

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, jwtCookie.toString(), authUser.toString()).build();
    }

    @GetMapping("/signin")
    public RedirectView authenticateUserParam(@RequestParam String contactNumber, @RequestParam String password, RedirectAttributes attributes, HttpServletResponse response) {
        Authentication authentication = null;
        try {
            authentication = authenticationManager
                    .authenticate(new UsernamePasswordAuthenticationToken(contactNumber, password));
        }catch (Exception e) {
            attributes.addFlashAttribute("failureMsg", "Incorrect username or password!");
            return new RedirectView("/login");
        }


        SecurityContextHolder.getContext().setAuthentication(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        String jwt = jwtUtil.generateJwt(userDetails);
        logger.info("JWT Generated: " + jwt);

        String cookieString = jwt;
        Cookie cookie = new Cookie("JWT", cookieString);
        cookie.setDomain("localhost");
        cookie.setPath("/");
        cookie.setSecure(false);
        cookie.setHttpOnly(false);
        cookie.setMaxAge(1*24*60*60);

        Cookie cookie2 = new Cookie("User", userDetails.getNumber());
        cookie.setDomain("localhost");
        cookie.setPath("/");
        cookie.setSecure(false);
        cookie.setHttpOnly(false);
        cookie.setMaxAge(1*24*60*60);

        response.addCookie(cookie);
        response.addCookie(cookie2);

        return new RedirectView("/home");
    }

    @DeleteMapping("deleteAllVol")
    public ResponseEntity deleteAll() {
        volunteerService.deleteAllUser();
        return new ResponseEntity(HttpStatus.OK);
    }

    @GetMapping("allVolunteer")
    public List<Volunteer> getAllVolunteer() {
        return volunteerService.getAllVolunteer();
    }

    @GetMapping("logoutUser")
    public ResponseEntity<?> logoutUser() {
        System.out.println("Logout method called");
        ResponseCookie cookie = ResponseCookie.from("JWT", null).build();
        ResponseCookie authUser = ResponseCookie.from("User", null).build();

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString(), authUser.toString()).build();
    }


    @GetMapping("/register")
    public String registerUser(Model model, @CookieValue(value = "JWT", required = false) String jwt) {
        if(jwt!=null && jwtUtil.validateJwtToken(jwt)) {
            return "redirect:/home";
        }
        return "register.jsp";
    }

    @GetMapping("/login")
    public String loginUser(Model model,
                            HttpServletRequest request, HttpServletResponse response,
                            @CookieValue(value = "JWT", required = false) String jwt) {
//        model.addAttribute("UUID", pass);
//        String jwt1 = response.getHeader("jwt");
//        if(jwt1 !=null && response.getHeader("jwt").equalsIgnoreCase("invalid"))
//            model.addAttribute("failureMsg", "Logged Out Successfully!");

//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if(jwt!=null && jwtUtil.validateJwtToken(jwt)) {
            return "redirect:/home";
        }
//
//        if(authentication!=null && authentication instanceof AnonymousAuthenticationToken) {
//            return "redirect:/home";
//        }

        String customHeader = (String) request.getSession().getAttribute("JWT");
        if (customHeader != null && customHeader.equalsIgnoreCase("Invalid")) {
            response.addHeader("JWT", customHeader);
            model.addAttribute("failureMsg", "Logged Out Successfully!");
            request.getSession().removeAttribute("JWT");
        }

//        System.out.println(Authorization);

        return "login.jsp";
    }

}
