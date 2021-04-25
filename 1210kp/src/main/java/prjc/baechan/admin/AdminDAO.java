package prjc.baechan.admin;



import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import prjc.baechan.common.CouponDTO;
import prjc.baechan.common.CouponVO;

@Mapper
public interface AdminDAO {

	public ArrayList<CouponVO> couponList(CouponDTO param) throws Exception;
	public int couponUpdtRgstChk(String[] couponIdArr) throws Exception;
	public int couponDeleteAjax(String[] couponIdArr)throws Exception;
	public int couponMakeAjax(CouponDTO param)throws Exception;
	public CouponVO updateCouponView(CouponDTO param) throws Exception;
	public int couponUpdateAjax(CouponDTO param) throws Exception;
}
