package project.mcq.portal.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.mcq.portal.dao.TestDao;
import project.mcq.portal.dao.UserDao;
import project.mcq.portal.dao.UserTestDao;
import project.mcq.portal.entities.Test;
import project.mcq.portal.entities.User;
import project.mcq.portal.entities.UserTest;

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
	public ModelAndView login(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return new ModelAndView("login");
		} else {
			return new ModelAndView("redirect:/user_dashboard");
		}
	}

	@PostMapping("/loginForm")
	public ModelAndView handleAdmin(HttpServletRequest request, @RequestParam("mobile") String mobileNo,
			@RequestParam("password") String password, Model model) {

		try {
			User user = userDao.getUser(mobileNo, password);
			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				model.addAttribute("message", "Successfully logged in !!!!");
				return new ModelAndView("redirect:/user_dashboard");
			} else {
				model.addAttribute("message", "Can't find credentials");
				return new ModelAndView("/login");
			}
		} catch (DataAccessException e) {
			model.addAttribute("message", "Can't find credentials");
		}
		return new ModelAndView("redirect:/user_dashboard");
	}

	@GetMapping(value = "/register")
	public String register() {
		return "register";
	}

	@RequestMapping(value = "/registerForm", method = RequestMethod.POST)
	public ModelAndView registerUser(@RequestParam("name") String fullName, @RequestParam("mobile") String mobileNo,
			@RequestParam("password") String password, Model model) {
		User user = new User();
		user.setName(fullName);
		user.setMobileNo(mobileNo);
		user.setPassword(password);
		int result = userDao.insertUser(user);
		if (result > 0) {
			model.addAttribute("message", "Successfully Registered in");
			return new ModelAndView("login");
		} else {
			model.addAttribute("message", "Not able to registered");
			return new ModelAndView("register");
		}
	}
//	User Login and SingUp ends here

	@GetMapping("/user_dashboard")
	public ModelAndView userDashboad(Model model) {
		List<Test> listOfTests = testDao.getListOfTests();
		model.addAttribute("listOfTests", listOfTests);
		return new ModelAndView("user_dashboard");

	}

	// Logout method here
	@GetMapping("/logout_user")
	public String processLogout(HttpSession session, Model attr) {

		System.out.println(session.getAttribute("user"));
		session.invalidate();
		attr.addAttribute("message", "Logged out successfully");
		return "redirect:/home";
	}

	// Show completed tests
	@GetMapping("/user_test")
	public ModelAndView userTest(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			List<UserTest> userListOfTests = userTestDao.getAllUserTest(user.getUserId());
			model.addAttribute("userListOfTests", userListOfTests);
			return new ModelAndView("user_test");
		} else {
			return new ModelAndView("redirect:/home");
		}
	}

}