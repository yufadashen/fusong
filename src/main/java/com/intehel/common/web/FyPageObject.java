package com.intehel.common.web;

import java.util.List;
import java.util.Map;

public class FyPageObject {

	/** 每页显示数目* */
    private int                       perPageNum;
    /** 第几页* */
    private int                       pageNumber;
    /** 数据* */
    private List<Map<String, String>> rows;
    /**第几页*/
    private long                      total;
    
    
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public List<Map<String, String>> getRows() {
		return rows;
	}
	public void setRows(List<Map<String, String>> rows) {
		this.rows = rows;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	
	

}
