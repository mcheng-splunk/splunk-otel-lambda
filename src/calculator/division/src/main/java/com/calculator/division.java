package com.calculator;

import java.util.Map;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import java.io.*;
import com.google.gson.Gson;
import java.util.HashMap;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.UUID;

import javax.management.openmbean.TabularType;

import com.calculate.util.*;
import com.google.gson.GsonBuilder;


public class division {

    public DivResponse handleRequest(Map<String, Object> input, Context context) {

        LambdaLogger logger = context.getLogger();
        logger.log("received : " + input);

        UUID transactionId = UUID.randomUUID();
        System.out.println("uuid is " + transactionId);

        float num1 = Integer.parseInt(input.get("operand1").toString());
        float num2 = Integer.parseInt(input.get("operand2").toString());

        float result = num1 / num2;
        System.out.println("result is " + result + "\n");
        logger.log("results is " + result + "\n");

        Gson gson = new Gson();

        DivResponse divResponse = new DivResponse();
        divResponse.setResult(result);
        divResponse.setSuccess(true);
        divResponse.setTransactionId(transactionId);
        System.out.println("the json is " + gson.toJson(divResponse) + "\n");

        return divResponse;

    }
}