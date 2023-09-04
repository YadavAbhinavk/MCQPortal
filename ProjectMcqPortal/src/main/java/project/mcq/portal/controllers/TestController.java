package project.mcq.portal.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.mcq.portal.dao.QuestionDao;
import project.mcq.portal.dao.TestDao;
import project.mcq.portal.dao.UserTestDao;
import project.mcq.portal.entities.Question;
import project.mcq.portal.entities.Tests;
import project.mcq.portal.entities.Users;
import project.mcq.portal.entities.UserTest;

@Controller
public class TestController {

	@Autowired
	TestDao testDao;

	@Autowired
	QuestionDao quesDao;
	
	@Autowired
	UserTestDao userTestDao;
	
	
//	Test creation starts here
	@GetMapping("/add_test")
	public ModelAndView addTest(@ModelAttribute("message")String message,Model model) {
		model.addAttribute("message",message);
		return new ModelAndView("add_test");
	}
	

	@PostMapping(value = "/testForm")
	public ModelAndView addTestWithTag(@RequestParam("tag") String tag, @RequestParam("questions") int numOfQues,
			Model model,RedirectAttributes redirectAttributes) {
		Tests test = new Tests();
		
		int check = testDao.getTest(tag), result = 0;
		if (check > 0) {
			redirectAttributes.addFlashAttribute("message", "Test Already exists");
		} else {
			test.setTag(tag);
			result = testDao.insertTest(test);
		}
		if (result > 0) {
			model.addAttribute("tag", tag);
			model.addAttribute("numOfQues", numOfQues);
			return new ModelAndView("add_questions");
		}
		return new ModelAndView("redirect:/add_test");
	}
//	Test creation ends here

//Test deletion function starts here
	@GetMapping("/delete_test/{tag}")
	public String deleteTest(@PathVariable("tag") String tag,RedirectAttributes redirectAttributes) {

		int result = testDao.deleteTest(tag);
		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "Test deleted successfully");
		} else {
			redirectAttributes.addFlashAttribute("message", "Test was not deleted");
		}
		return "redirect:/admin_dashboard";
	}

//Test deletion ends here

// Test update function starts here
	@GetMapping("/update_tests/{tag}")
	public String updateTest(@PathVariable("tag") String tag,@ModelAttribute("message") String message, Model model) {
		
		String available = testDao.getAvailability(tag);
		List<Question> listOfQuestions = quesDao.getAllQuestionByTag(tag);
		model.addAttribute("listOfQuestions", listOfQuestions);
		model.addAttribute("tag",tag);
		model.addAttribute("isAvailable",available);
		model.addAttribute("message",message);
		return "edit_tests";
	}

// Test update function ends here
	
	@GetMapping("/option/{tag}")
	public String getAvailability(@PathVariable("tag") String tag,@RequestParam("isAvailable") String available,RedirectAttributes redirectAttributes)
	{
		Tests test = new Tests();
		test.setTag(tag);
		List<Tests> listOfTest = testDao.getListOfTests();
		int num = 0;
		for(int i =0;i < listOfTest.size();i++)
		{
			if(listOfTest.get(i).getTag().equalsIgnoreCase(tag))
			{
				num = listOfTest.get(i).getNumberOfQuestions();
			}
		}
		if(num == 0 && available.equalsIgnoreCase("active"))
		{
			redirectAttributes.addFlashAttribute("message","Test cannot be set to active as it has no questions");
			return "redirect:/update_tests/{tag}";
		}
		test.setIsAvailable(available);
		int result = testDao.updateTest(test);
		if(result > 0)
		{
			redirectAttributes.addFlashAttribute("message", "Test status updated to "+available);
		}
		else
		{
			redirectAttributes.addFlashAttribute("message", "Test status was not updated");
		}
		return "redirect:/update_tests/{tag}";
		
	}
	
//	updating a question function starts here
	@GetMapping("/update_ques/{questionId}")
	public String updateQuestion(@PathVariable("questionId") int quesId,Model model)
	{
		
		Question question = quesDao.getQuestion(quesId);
		String available = testDao.getAvailability(question.getTag());
		
		model.addAttribute("questionToUpdate",question);
		model.addAttribute("isAvailable", available);
		return "update_ques";
	}
	//adding questions function starts here
		@GetMapping("/add_question/{tag}")
		public ModelAndView addQuestion(@PathVariable("tag") String tag, @RequestParam("numOfQues") int numOfQues,
				Model model) {
			model.addAttribute("tag", tag);
			model.addAttribute("numOfQues", numOfQues);

			return new ModelAndView("add_questions");
		}
	//adding questions function starts here	
	@PostMapping("/updateForm/{questionId}/{tag}")
	public String handleUpdateQuestion(@PathVariable("questionId") int quesId,@PathVariable("tag") String tag,
			@RequestParam("ques_name") String ques_name,@RequestParam("option1") String option1,
			@RequestParam("option2") String option2,
			@RequestParam("option3") String option3,@RequestParam("option4") String option4,
			@RequestParam("answer") String answer,Model model,RedirectAttributes redirectAttributes)
	{
		System.out.println("udpate page"+quesId);
		Question ques = new Question();
		ques.setQuestionId(quesId);
		ques.setQuestionName(ques_name);
		ques.setOption1(option1);
		ques.setOption2(option2);
		ques.setOption3(option3);
		ques.setOption4(option4);
		ques.setCorrectAnswer(answer);
		System.out.println(ques);
		int result = quesDao.updateQues(ques);
		if(result > 0)
		{
			redirectAttributes.addFlashAttribute("message","Succesfully updated question");
		}
		else
		{
			redirectAttributes.addFlashAttribute("message","Not able to update the question");
		}
		return "redirect:/update_tests/{tag}";
	}
//	updating a question function ends here
	
	
//	adding questions starts here

	@PostMapping(value = "/quesForm/{tag}")
	public String handleQues(Model model, HttpServletRequest request,@PathVariable("tag") String tag) {
		System.out.println("Question Page");
		Question ques = new Question();
		
		ques.setTag(tag);
		ques.setQuestionName(request.getParameter("ques_name"));
		ques.setOption1(request.getParameter("option1"));
		ques.setOption2(request.getParameter("option2"));
		ques.setOption3(request.getParameter("option3"));
		ques.setOption4(request.getParameter("option4"));
		ques.setCorrectAnswer(request.getParameter("answer"));
		
		int result = quesDao.insertQues(ques);
		if(result > 0)
		{
			model.addAttribute("message","Question added succesfully");
		}
		else
		{
			model.addAttribute("message","Not able to add Question");
		}
    model.addAttribute("tag", tag);
	return "add_questions";
	}
//	adding questions ends here	
	
//delete questions function starts here	
	
	@GetMapping("/delete_ques/{questionId}/{tag}")
	public String deleteQuestion(@PathVariable("questionId") int quesId,@PathVariable("tag") String tag,Model model
			,RedirectAttributes redirectAttributes)
	{
		int result = quesDao.deleteQues(quesId);
		String available = testDao.getAvailability(tag);
		if(result == 0)
		{
			redirectAttributes.addFlashAttribute("message","Question was not deleted");
		}
		redirectAttributes.addFlashAttribute("message","Question was deleted");
		return "redirect:/update_tests/{tag}";
	}
//      delete questions function ends here		
	

	
//      user test starts here
		@GetMapping("/start_test/{tag}")
		public String startTest(@PathVariable("tag") String tag,HttpSession session, Model model,RedirectAttributes redirectAttributes) {

			
			Users user = (Users) session.getAttribute("user");
			if (user == null) {
				return "redirect:/login";
			}
			
		    
		    
		    
			String available = testDao.getAvailability(tag);
			List<Question> allQuestions = quesDao.getAllQuestionByTag(tag);

			int maxQuestions = allQuestions.size();
			int numberOfQuestionsToShow;

			if (maxQuestions >= 25) {
				numberOfQuestionsToShow = 20;
			} else if (maxQuestions > 10 && maxQuestions < 25) {
				numberOfQuestionsToShow = 10;
			} else {
				numberOfQuestionsToShow = maxQuestions;
			}

			List<Question> randomQuestions = new ArrayList<>();
			if (numberOfQuestionsToShow > 0 && maxQuestions > 0) {
			    Random random = new Random();
			    
			    // Create a copy of allQuestions to avoid modifying the original list
			    List<Question> availableQuestions = new ArrayList<>(allQuestions);
			    
			    for (int i = 0; i < numberOfQuestionsToShow; i++) {
			        if (availableQuestions.isEmpty()) {
			            // All questions have been added; break the loop
			            break;
			        }
			        
			        int randomIndex = random.nextInt(availableQuestions.size());
			        randomQuestions.add(availableQuestions.remove(randomIndex));
			    }
			}

			model.addAttribute("listOfQuestions", randomQuestions);
			model.addAttribute("tag",tag);
			model.addAttribute("isAvailable",available);
			
			return "start_test";
		}
//      user test ends here		
		
//      user test answer submission and calculation atarts here		
		@PostMapping("/processSelectedRadioValues/{tag}")
	    public String processSelectedRadio(HttpServletRequest request,@PathVariable("tag") String tag,Model model, HttpSession session) {
	        // Getting the Radio Button values that were selected
			List<String> selectedRadioValues = new ArrayList<>();
			List<Integer> scores = new ArrayList<>();
			List<Question> listOfQuestions = new ArrayList<>();
			
			// Get the parameter values from the request
	        String[] questionIds = request.getParameterValues("questionId");
	        
	        int score = 0;
	        if(questionIds != null) {
	        for(String id:questionIds)	
	        {
	        	listOfQuestions.add(quesDao.getQuestion(Integer.parseInt(id)));
	        	selectedRadioValues.add(request.getParameter("answer"+id));
	        	String ques_answer = quesDao.getAnswer(Integer.parseInt(id));
	        	 if(ques_answer.equalsIgnoreCase(request.getParameter("answer"+id)))
	        	 {	 
	        		 score++;
	        		 scores.add(1);
	        	 }
	        	 else
	        	 {
	        		 scores.add(0);
	        	 }
	        }
	        }
	        model.addAttribute("score",score);
	        model.addAttribute("listOfScores",scores);
	        model.addAttribute("listOfQuestions",listOfQuestions);
	        model.addAttribute("selectedRadioValues",selectedRadioValues);
	        
	        Users user = (Users)session.getAttribute("user");
	        int userId = user.getUserId();
	        UserTest userTest = new UserTest();
	    	userTest.setScore(score);
	    	userTest.setTag(tag);
	    	userTest.setSubmissionTime(request.getParameter("submissionTime"));
	    	userTest.setUserId(userId);
	    	
	    	userTestDao.insertUser(userTest);
	    
	        return "score"; 
	    }
//      user test answer submission and calculation ends here			
		
//      method checks if test is active when the user is giving the test		
		@GetMapping("/checkTestStatus")
		@ResponseBody
		public String checkTestStatus(@RequestParam("tag") String tag) {
			// Retrieve the test status based on the test name
			String testStatus = testDao.getAvailability(tag); 
			// Return the test status as a response (active or inactive)
			return testStatus; 
		}

}
