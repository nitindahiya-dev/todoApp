import React, { useEffect, useState } from "react";
import Web3Modal from "web3modal";
import { ethers } from "ethers";
import { todoListAddress, todoListABI } from "./constants";

const fetchContract = (signerorProvider) =>
  new ethers.Contract(todoListABI, todoListAddress, signerorProvider);

export const TodoListContext = React.createContext();

export const TodoListProvider = ({ children }) => {
  
    const [currentAccount, setCurrentAccount] = useState("");
    const [error, setError] = useState("");
    cosnt [allTodoList, setAllTodoList] = useState([]);
    const [myList, setMyList] = useState([])
    const [allAddress, setAllAddress] = useState([]);

    const checkIfWalletIsConnect = async() => {
        if(!window.ethereum) return setError("please intall MetaMask");

        const account = await window.ethereum.request({method: "eth_accounts"});

        if(account.length){
            setCurrentAccount(account[0])
            console.log(account[0]);
            
        } else {
            setError("Please install MetaMask & Connect, Reload")
        }
    };

    // useEffect(()=> {
    //     checkIfWalletIsConnect();
    // }, [])



    return (
    <TodoListContext.Provider value={{checkIfWalletIsConnect}}>{children}</TodoListContext.Provider>
  );
};
