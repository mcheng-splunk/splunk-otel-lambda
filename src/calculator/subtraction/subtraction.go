package main

import (
	"fmt"
	"strconv"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/google/uuid"
)

type MyEvent struct {
	Operand1 string `json:"operand1"`
	Operand2 string `json:"operand2"`
	Operator string `json:"operator"`
}

type MyResponse struct {
	Result        int    `json:"Result"`
	Success       bool   `json:"StatusCode"`
	TransactionId string `json:"TransactionId"`
}

func HandleLambdaEvent(event MyEvent) (MyResponse, error) {
	transactionId := uuid.New()

	num1, _ := strconv.Atoi(event.Operand1)
	num2, _ := strconv.Atoi(event.Operand2)

	result := num1 - num2
	fmt.Println("Result is ", result)
	fmt.Println("transaction is ", transactionId)

	return MyResponse{
		Result:        result,
		Success:       true,
		TransactionId: transactionId.String(),
	}, nil

}

func main() {
	lambda.Start(HandleLambdaEvent)
}
