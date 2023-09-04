package mcq.portal.controllers.test;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.mcq.portal.controllers.UserController;
import project.mcq.portal.dao.TestDao;
import project.mcq.portal.dao.UserDao;
import project.mcq.portal.dao.UserTestDao;
import project.mcq.portal.entities.Tests;
import project.mcq.portal.entities.Users;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class UserControllerTest {

    @InjectMocks
    private UserController userController;

    @Mock
    private UserDao userDao;

    @Mock
    private UserTestDao userTestDao;

    @Mock
    private TestDao testDao;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpSession session;

    @Mock
    private Model model;

    @Mock
    private RedirectAttributes redirectAttributes;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testLoginWithValidUser() {
        Users user = new Users();
        when(request.getSession()).thenReturn(session);
        when(userDao.getUser(anyString(), anyString())).thenReturn(user);

        ModelAndView modelAndView = userController.handleUser(request, "mobile", "password", model, redirectAttributes);

        assertEquals("redirect:/user_dashboard", modelAndView.getViewName());
        assertEquals(null, session.getAttribute("user"));
    }

    @Test
    public void testLoginWithInvalidCredentials() {
        when(userDao.getUser(anyString(), anyString())).thenReturn(null);

        ModelAndView modelAndView = userController.handleUser(request, "invalidMobile", "invalidPassword", model, redirectAttributes);

        assertEquals("redirect:/login", modelAndView.getViewName());
        verify(redirectAttributes).addFlashAttribute("message", "Invalid Credentials");
    }

    @Test
    public void testRegisterUserSuccess() {
        when(userDao.insertUser(any(Users.class))).thenReturn(1);

        ModelAndView modelAndView = userController.registerUser("John Doe", "newMobile", "newPassword", model, redirectAttributes);

        assertEquals("redirect:/login", modelAndView.getViewName());
        verify(redirectAttributes).addFlashAttribute("message", "Successfully Registered in");
    }

    @Test
    public void testRegisterUserFailure() {
        when(userDao.insertUser(any(Users.class))).thenReturn(0);

        ModelAndView modelAndView = userController.registerUser("Invalid Name", "invalidMobile", "invalidPassword", model, redirectAttributes);

        assertEquals("redirect:/register", modelAndView.getViewName());
        verify(redirectAttributes).addFlashAttribute("message", "Not able to registered");
    }

    @Test
    public void testUserDashboard() {
        List<Tests> listOfTests = new ArrayList<>();
        when(testDao.getListOfTests()).thenReturn(listOfTests);

        ModelAndView modelAndView = userController.userDashboad(model, "");

        assertEquals("user_dashboard", modelAndView.getViewName());
        assertEquals(listOfTests, model.getAttribute("listOfTests"));
    }

    // You can add more test cases for other methods as needed
}

