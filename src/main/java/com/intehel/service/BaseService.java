package com.intehel.service;

import java.util.List;

import org.apache.ibatis.annotations.Options;

/**
 * 通用Service
 */
public interface BaseService<T> {

    List<T> list(T entity);

    T get(T entity);

    int update(T entity);
    
    @Options(useGeneratedKeys = true, keyProperty = "ID_")
    int save(T entity);

    int delete(T entity);

}
