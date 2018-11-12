package com.acq.web.controller.model;
import javax.validation.constraints.Pattern;

public class AcqTransactionModel {
 

 @Pattern(regexp="^[0-9]{0,3}$",message="Invalid min result") 
 private String minResult;
 

 @Pattern(regexp="^[0-9]{0,3}$",message="Invalid max result") 
 private String maxResult;

 public String getMinResult() {
  return minResult;
 }

 public void setMinResult(String minResult) {
  this.minResult = minResult;
 }

 public String getMaxResult() {
  return maxResult;
 }

 public void setMaxResult(String maxResult) {
  this.maxResult = maxResult;
 }
 
 
 
}