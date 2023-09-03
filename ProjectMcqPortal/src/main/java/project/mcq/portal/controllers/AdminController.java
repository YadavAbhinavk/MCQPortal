package project.mcq.portal.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.mcq.portal.dao.AdminDao;
import project.mcq.portal.dao.TestDao;
import project.mcq.portal.entities.Admin;
import project.mcq.portal.entities.Test;

@Controller
public class AdminController {
	
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	TestDao testDao;

//	Admin Login starts here	
	@GetMapping("/admin")
	public ModelAndView admin(HttpSession session) {
		Admin admin = (Admin)session.getAttribute("admin");
		if(admin == null)
		{
			return new ModelAndView("admin_login");
		}
		else
		{
			return new ModelAndView("redirect:/admin_dashboard");
		}
	}

	@PostMapping("/adminForm")
	public ModelAndView handleAdmin(HttpServletRequest request,@RequestParam("username") String username, @RequestParam("password") String password,
			Model model) {

		try
		{
			Admin admin = adminDao.getAdmin(username, password);
			if (admin != null) {
				HttpSession session = request.getSession();
				session.setAttribute("admin", admin);
				return new ModelAndView("redirect:/admin_dashboard");
			}	
			else
			{
				model.addAttribute("message","Invalid Credentials");
				return new ModelAndView("admin_login");
			}
		}
		catch(DataAccessException e)
		{
			model.addAttribute("message", "Can't find credentials");
		}
		return new ModelAndView("redirect:/admin_dashboard");
	}
	
	@GetMapping("/admin_dashboard")
	public ModelAndView adminDashboad(Model model,HttpSession session,@ModelAttribute("message") String message)
	{
		Admin admin = (Admin)session.getAttribute("admin");

		if(admin != null)
		{
			List<Test> listOfTests = testDao.getListOfTests();
			model.addAttribute("listOfTests",listOfTests);
			return new ModelAndView("admin_dashboard");
		}
		else
		{
			return new ModelAndView("redirect:/home");
		}
		
	}
//	Admin Login ends here
}

