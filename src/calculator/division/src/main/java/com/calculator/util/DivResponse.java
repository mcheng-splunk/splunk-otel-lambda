
package com.calculate.util;

import java.util.*;

public class DivResponse {
    private float Result;
    private boolean Success;
    private UUID transactionId;

    public DivResponse() {

    }

    public DivResponse(float Result, boolean Success, UUID transactionId) {
        this.Result = Result;
        this.Success = Success;
        this.transactionId = transactionId;
    }

    public float getResult() {
        return this.Result;
    }

    public void setResult(float Result) {
        this.Result = Result;
    }

    public boolean isSuccess() {
        return this.Success;
    }

    public boolean getSuccess() {
        return this.Success;
    }

    public void setSuccess(boolean Success) {
        this.Success = Success;
    }

    public UUID getTransactionId() {
        return this.transactionId;
    }

    public void setTransactionId(UUID transactionId) {
        this.transactionId = transactionId;
    }

    @Override
    public String toString() {
        return "{" +
                " Result='" + getResult() + "'" +
                ", Success='" + isSuccess() + "'" +
                ", transactionId='" + getTransactionId() + "'" +
                "}";
    }

}
