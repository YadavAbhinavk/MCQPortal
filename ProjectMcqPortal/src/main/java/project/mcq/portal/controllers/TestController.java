package project.mcq.portal.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.mcq.portal.dao.QuestionDao;
import project.mcq.portal.dao.TestDao;
import project.mcq.portal.dao.UserTestDao;
import project.mcq.portal.entities.Question;
import project.mcq.portal.entities.Test;
import project.mcq.portal.entities.User;
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
	@RequestMapping("/add_test")
	public ModelAndView addTest() {
		return new ModelAndView("add_test");
	}
	

	@PostMapping(value = "/testForm")
	public ModelAndView addTestWithTag(@RequestParam("tag") String tag, @RequestParam("questions") int numOfQues,
			Model model) {
		Test test = new Test();
		
		int check = testDao.getTest(tag), result = 0;
		if (check > 0) {
			model.addAttribute("message", "Test Already exists");
		} else {
			test.setTag(tag);

			result = testDao.insertTest(test);
		}
		if (result > 0) {
			model.addAttribute("tag", tag);
			model.addAttribute("numOfQues", numOfQues);

			return new ModelAndView("add_questions");
		}
		model.addAttribute("message", "Not able to create a new test");
		return new ModelAndView("add_test");
	}
//	Test creation ends here

//Test deletion function starts here
	@GetMapping("/delete_test/{tag}")
	public String deleteTest(@PathVariable("tag") String tag, Model model) {

		int result = testDao.deleteTest(tag);
		List<Test> listOfTests = testDao.getListOfTests();
		model.addAttribute("listOfTests", listOfTests);
		if (result > 0) {
			model.addAttribute("message", "Test deleted successfully");
		} else {
			model.addAttribute("message", "Test was not deleted");
		}
		return "admin_dashboard";
	}

//Test deletion ends here

// Test update function starts here
	@GetMapping("/update_tests/{tag}")
	public String updateTest(@PathVariable("tag") String tag, Model model) {

		String available = testDao.getAvailability(tag);
		List<Question> listOfQuestions = quesDao.getAllQuestionByTag(tag);
		model.addAttribute("listOfQuestions", listOfQuestions);
		model.addAttribute("tag",tag);
		model.addAttribute("isAvailable",available);
		
		return "edit_tests";
	}

// Test update function ends here
	
	@RequestMapping(path="/option/{tag}")
	public String getAvailability(@PathVariable("tag") String tag,@RequestParam("isAvailable") String available,Model model)
	{
		Test test = new Test();
		test.setTag(tag);
		test.setIsAvailable(available);
		int result = testDao.updateTest(test);
		if(result > 0 )
		{
			System.out.println("Updated succesfully");
		}
		List<Question> listOfQuestions = quesDao.getAllQuestionByTag(tag);
		model.addAttribute("listOfQuestions", listOfQuestions);
		model.addAttribute("tag",tag);
		model.addAttribute("isAvailable", available);
		return "edit_tests";
		
	}
//adding single question function starts here
	@GetMapping("/add_question/{tag}")
	public ModelAndView addQuestion(@PathVariable("tag") String tag,@RequestParam("numOfQues") int numOfQues,Model model)
	{
		model.addAttribute("tag", tag);
		model.addAttribute("numOfQues", numOfQues);

		return new ModelAndView("add_questions");
	}
//adding single question function starts here	
	
	
//	updating a question function starts here
	@GetMapping("/update_ques/{questionId}")
	public String updateQuestion(@PathVariable("questionId") int quesId,Model model)
	{
		
		Question question = quesDao.getQuestion(quesId);
		String available = testDao.getAvailability(question.getTag());
		System.out.println(question);
		model.addAttribute("questionToUpdate",question);
		model.addAttribute("isAvailable", available);
		return "update_ques";
	}
	
	@PostMapping(path="updateForm/{questionId}/{tag}")
	public String handleUpdateQuestion(@PathVariable("questionId") int quesId,@PathVariable("tag") String tag,
			@RequestParam("ques_name") String ques_name,@RequestParam("option1") String option1,
			@RequestParam("option2") String option2,
			@RequestParam("option3") String option3,@RequestParam("option4") String option4,
			@RequestParam("answer") String answer,Model model)
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
			model.addAttribute("message","Succesfully updated");
			return "redirect:/update_tests/{tag}";
		}
		else
		{
			model.addAttribute("message","Not able to update");
		}
		return "update_ques";
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
	public String deleteQuestion(@PathVariable("questionId") int quesId,@PathVariable("tag") String tag,Model model)
	{
		int result = quesDao.deleteQues(quesId);
		String available = testDao.getAvailability(tag);
		if(result == 0)
		{
			model.addAttribute("message","Question was not deleted");
		}
		model.addAttribute("isAvailable",available);
		return "redirect:/update_tests/{tag}";
	}
//delete questions function ends here		
	
	//START
	
	
		@GetMapping("/start_test/{tag}")
		public String startTest(@PathVariable("tag") String tag, Model model) {

			String available = testDao.getAvailability(tag);
			List<Question> listOfQuestions = quesDao.getAllQuestionByTag(tag);
			model.addAttribute("listOfQuestions", listOfQuestions);
			model.addAttribute("tag",tag);
			model.addAttribute("isAvailable",available);
			
			return "start_test";
		}
		
		
		@GetMapping( "/score/{correct_ans}")
		public String calcScore(@PathVariable List<String> correct_ans) 
		{
			System.out.println(correct_ans);
//			System.out.println(ans);
			return "score";
		}
		
		@PostMapping("/processSelectedRadioValues/{tag}")
	    public String processSelectedRadio(HttpServletRequest request,@PathVariable("tag") String tag,Model model, HttpSession session) {
	        // Getting the Radio Button values that were selected
			List<String> selectedRadioValues = new ArrayList<>();
			List<Integer> scores = new ArrayList<>();
			List<Question> listOfQuestions = new ArrayList<>();
			
			// Get the parameter values from the request
	        String[] questionIds = request.getParameterValues("questionId");
	        
	        int score = 0;
	        for(String id:questionIds)
	        {
//	        	System.out.println("answer"+id);
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
	        
	        System.out.println(selectedRadioValues);
	        model.addAttribute("score",score);
	        model.addAttribute("listOfScores",scores);
	        model.addAttribute("listOfQuestions",listOfQuestions);
	        model.addAttribute("selectedRadioValues",selectedRadioValues);
	        
	        System.out.println(scores);
	        System.out.println(listOfQuestions);
	        User user = (User)session.getAttribute("user");
	        System.out.println("User Details:"+ user);
	        int userId = user.getUserId();
	        System.out.println("User Id: "+userId);
	        UserTest userTest = new UserTest();
	    	userTest.setScore(score);
	    	userTest.setTag(tag);
	    	userTest.setSubmissionTime(request.getParameter("submissionTime"));
	    	userTest.setUserId(userId);
	    	System.out.println("User Test: "+userTest);
	    	userTestDao.insertUser(userTest);
	        
			
	        // Redirect to the appropriate view
	        return "score"; 
	    }

}
