package project.mcq.portal.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.mcq.portal.dao.*;
import project.mcq.portal.entities.*;


@Controller
public class UserController {

	@Autowired
	UserDao userDao;

	@Autowired
	UserTestDao userTestDao;

	@Autowired
	TestDao testDao;

//	User login and register
	@GetMapping(value = "/login")
	public ModelAndView login(HttpSession session,@ModelAttribute("message") String message,Model model) {
		Admin admin = (Admin) session.getAttribute("admin");
		Users user = (Users) session.getAttribute("user");
		if (user == null && admin == null) {
			model.addAttribute("message",message);
			return new ModelAndView("login");
		}
		if(admin != null && user == null)
		{
			return new ModelAndView("redirect:/home");
		}
		else {
			return new ModelAndView("redirect:/user_dashboard");
		}
	}

	@PostMapping("/loginForm")
	public ModelAndView handleUser(HttpServletRequest request, @RequestParam("mobile") String mobileNo,
			@RequestParam("password") String password, Model model,RedirectAttributes redirectAttributes) {

		try {
			Users users = userDao.getUser(mobileNo, password);
			if (users != null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", users);
				model.addAttribute("message", "Successfully logged in !!!!");
				return new ModelAndView("redirect:/user_dashboard");
			} else {
				redirectAttributes.addFlashAttribute("message","Invalid Credentials");
				return new ModelAndView("redirect:/login");
			}
		} catch (DataAccessException e) {
			model.addAttribute("message", "Can't find credentials");
		}
		return new ModelAndView("redirect:/user_dashboard");
	}

	@GetMapping(value = "/register")
	public String register(@ModelAttribute("message") String message,HttpSession session,Model model) {
		Admin admin = (Admin) session.getAttribute("admin");
		Users user = (Users) session.getAttribute("user");
		if(admin != null && user == null)
		{
			return "redirect:/home";
		}
		model.addAttribute("message",message);
		return "register";
	}

	@RequestMapping(value = "/registerForm", method = RequestMethod.POST)
	public ModelAndView registerUser(@RequestParam("name") String fullName, @RequestParam("mobile") String mobileNo,
			@RequestParam("password") String password, Model model,RedirectAttributes redirectAttributes) {
		Users user = new Users();
		user.setName(fullName);
		user.setMobileNo(mobileNo);
		user.setPassword(password);
		int result = userDao.insertUser(user);
		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "Successfully Registered in");
			return new ModelAndView("redirect:/login");
		} else {
			redirectAttributes.addFlashAttribute("message","Not able to registered");
			return new ModelAndView("redirect:/register");
		}
	}
//	User Login and SingUp ends here

	@GetMapping("/user_dashboard")
	public ModelAndView userDashboad(Model model,@ModelAttribute("message")String message) {
		List<Tests> listOfTests = testDao.getListOfTests();
		model.addAttribute("listOfTests", listOfTests);
		model.addAttribute("message", message);
		return new ModelAndView("user_dashboard");
	}

	// Show completed tests
	@GetMapping("/user_test")
	public ModelAndView userTest(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("user");
		if (user != null) {
			List<UserTest> userListOfTests = userTestDao.getAllUserTest(user.getUserId());
			model.addAttribute("userListOfTests", userListOfTests);
			return new ModelAndView("user_test");
		} else {
			return new ModelAndView("redirect:/home");
		}
	}

}