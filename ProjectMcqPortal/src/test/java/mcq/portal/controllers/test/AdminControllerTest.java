package mcq.portal.controllers.test;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import project.mcq.portal.controllers.AdminController;
import project.mcq.portal.dao.AdminDao;
import project.mcq.portal.dao.TestDao;
import project.mcq.portal.entities.Admin;
import project.mcq.portal.entities.Tests;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class AdminControllerTest {

    @InjectMocks
    private AdminController adminController;

    @Mock
    private AdminDao adminDao;

    @Mock
    private TestDao testDao;

    @Mock
    private HttpSession session;

    @SuppressWarnings("deprecation")
	@BeforeEach
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }
    
    @Test
    public void testAdminWhenAdminIsNullAndUserIsNull() {
        HttpSession session = mock(HttpSession.class);
        when(session.getAttribute("admin")).thenReturn(null);
        when(session.getAttribute("user")).thenReturn(null);

        ModelAndView modelAndView = adminController.admin(session);

        assertEquals("admin_login", modelAndView.getViewName());
    }

    // Add similar test cases for other scenarios in the admin() method

    @Test
    public void testHandleAdminWithValidCredentials() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        Model model = mock(Model.class);
        Admin admin = new Admin(); // Create a mock admin object with valid credentials

        when(adminDao.getAdmin(anyString(), anyString())).thenReturn(admin);

        ModelAndView modelAndView = adminController.handleAdmin(request, "validUsername", "validPassword", model);

        assertEquals("redirect:/admin_dashboard", modelAndView.getViewName());
    }

    // Add similar test cases for other scenarios in the handleAdmin() method

    @Test
    public void testAdminDashboardWithAdminLoggedIn() {
        HttpSession session = mock(HttpSession.class);
        Admin admin = new Admin(); // Create a mock admin object

        when(session.getAttribute("admin")).thenReturn(admin);
        List<Tests> listOfTests = new ArrayList<>(); // Create a list of mock tests

        when(testDao.getListOfTests()).thenReturn(listOfTests);

        Model model = mock(Model.class);
        ModelAndView modelAndView = adminController.adminDashboad(model, session);

        assertEquals("admin_dashboard", modelAndView.getViewName());
        verify(model).addAttribute("listOfTests", listOfTests);
    }

    // Add similar test cases for other scenarios in the adminDashboad() method
}

