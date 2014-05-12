package com.aishang.manager;

import java.sql.SQLException;

import com.aishang.db.bean.Users;
import com.aishang.db.dao.UsersDAO;

/**
 * 
 * 1.超级管理员 <br/>
 * 2.工作人员 <br/>
 * 3.美发店 <br/>
 * 4.发型师 <br/>
 * 
 */
public class PermitManager {

	public static final UsersDAO DAO = new UsersDAO();

	public static boolean addUserPermit(Users own, Users users) {
//		if (users.getUserGroup_id() < own.getUserGroup_id())
//			return false;
		switch (own.getUserGroup_id()) {
		case 1:

			return true;
		case 2:

			return true;
		case 3:

			return true;
		case 4:
			return true;
		}
		return false;
	}

	public static boolean modifyUserPermit(Users own, Users users) throws ClassNotFoundException, SQLException {

//		if (DAO.getGroupID(users.getUsers_id()) < own.getUserGroup_id())
//			return false;

		switch (own.getUserGroup_id()) {
		case 1:

			return true;
		case 2:

			return true;
		case 3:

			return true;
		case 4:
			return true;
		}
		return false;
	}

	public static boolean deleteUserPermit(Users own, Users users) throws ClassNotFoundException, SQLException {
//		if (DAO.getGroupID(users.getUsers_id()) < own.getUserGroup_id())
//			return false;

		switch (own.getUserGroup_id()) {
		case 1:

			return true;
		case 2:

			return true;
		case 3:

			return true;
		case 4:
			return true;
		}
		return false;
	}
}
