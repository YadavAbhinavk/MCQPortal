package project.mcq.portal.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	@GetMapping(value = { "/","/home" })
	public ModelAndView home(Model model) {
		model.addAttribute("name", "Abhinav");
		System.out.println("Home page");
		return new ModelAndView("home");
	}
}
