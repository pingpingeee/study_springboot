package com.boot.dao;

import com.boot.dto.EmpDeptDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface EmpDeptDAO {
    public ArrayList<EmpDeptDTO> list();
}
