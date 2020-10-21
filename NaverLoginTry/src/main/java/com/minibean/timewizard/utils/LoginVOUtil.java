package com.minibean.timewizard.utils;

import java.util.UUID;

import javax.servlet.http.HttpSession;

public class LoginVOUtil {

    String SESSION_STATE = "";

    protected void setSession_state(String session_state) {
        this.SESSION_STATE = session_state;
    }

    protected String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    protected void setSession(HttpSession session, String state) {
        session.setAttribute(SESSION_STATE, state);
    }

    protected String getSession(HttpSession session) {
        return (String) session.getAttribute(SESSION_STATE);
    }
}
