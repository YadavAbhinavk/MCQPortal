package project.mcq.portal.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@GetMapping(value = { "/","/home" })
	public ModelAndView home(Model model) {
		
		return new ModelAndView("home");
	}
//Logout method here	
	@GetMapping("/logout")
	public String processLogout(HttpSession session, 
			Model attr) {

		System.out.println(session.getAttribute("admin"));
		session.invalidate();
		attr.addAttribute("message", "Logged out successfully");
		return "redirect:/home";
	}
}