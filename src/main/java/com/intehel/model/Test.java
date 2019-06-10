package com.intehel.model;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "TB_TEST")
public class Test {

    @Id
    @Column(name = "tb_id")
    private String tbId;
    @Column(name = "name")
    private String name;

    public String getTbId() {
        return tbId;
    }
    public void setTbId(String tbId) {
        this.tbId = tbId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
