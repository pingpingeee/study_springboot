package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmpDeptDTO {
//  emp table
//  xml 정보 뿐만 아니라 전체 테이블의 컬럼을 정의(개발시 유연성: DTO 공유 등)
//  join을 많이 하기 때문에 아래와 같은 형식으로 많이 사용
    private int empno;
    private String ename;
    private String job;
    private int mgr;
    private Timestamp hiredate;
    private int sal;
    private int comm;

//  공통 컬럼
    private int deptno;

//  dept table
    private String dname;
    private String loc;
}
