package prjc.baechan.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import prjc.baechan.common.CouponDTO;
import prjc.baechan.common.CouponVO;
import prjc.baechan.common.UserCouponVO;
import prjc.baechan.common.UserVO;
import prjc.baechan.common.paginationDTO;

@Service
public class AdminService implements AdminDAO{
	@Inject
	private AdminDAO AdminDAO;

	@Override
	public ArrayList<CouponVO> couponList(CouponDTO param) throws Exception {
		return AdminDAO.couponList(param);
	}

	@Override
	public int couponUpdtRgstChk(String[] couponIdArr) throws Exception {
		return AdminDAO.couponUpdtRgstChk(couponIdArr);
	}
	
	@Override
	public int couponDeleteAjax(String[] couponIdArr) throws Exception {
		return AdminDAO.couponDeleteAjax(couponIdArr);
	}
	
	@Override
	public int couponMakeAjax(CouponDTO param) throws Exception{
		return AdminDAO.couponMakeAjax(param);
	}
	
	@Override
	public CouponVO updateCouponView(CouponDTO param) throws Exception {
		return AdminDAO.updateCouponView(param);
	}

	@Override
	public int couponUpdateAjax(CouponDTO param) throws Exception {
		return AdminDAO.couponUpdateAjax(param);
	}
}