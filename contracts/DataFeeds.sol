// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DataFeedsTest
{
  // 利用する変数
  AggregatorV3Interface internal ETH_USD;
  AggregatorV3Interface internal USD_JPY;

  constructor() {
    /** -----------------------------------------------------------------
    ETH/USD : https://data.chain.link/feeds/ethereum/mainnet/eth-usd
    USD/JPY : https://data.chain.link/feeds/ethereum/mainnet/jpy-usd
    ------------------------------------------------------------------ */
    ETH_USD = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    USD_JPY = AggregatorV3Interface(0x8A6af2B75F23831ADc973ce6288e5329F63D86c6);
  }


  function get_Latest_EU_Price() public view returns (int256) {
    (
        /*uint80 roundID*/, // roundのid、roundidは毎回記録される
        int256 price, // 最新の価格をint型のpriceに代入
        /*uint startedAt*/, // roundスタートしたタイムスタンプ
        /*uint timeStamp*/, // data更新のタイムスタンプ
        /*uint80 answeredInRound*/ // どのroundで更新されたか
    ) = ETH_USD.latestRoundData(); 
    return price;
  }

  function get_Latest_JU_Price() public view returns (int256) {
    (
        /*uint80 roundID*/, // roundのid、roundidは毎回記録される
        int256 price, // 最新の価格をint型のpriceに代入
        /*uint startedAt*/, // roundスタートしたタイムスタンプ
        /*uint timeStamp*/, // data更新のタイムスタンプ
        /*uint80 answeredInRound*/ // どのroundで更新されたか
    ) = USD_JPY.latestRoundData(); 
    return price;
  }

  // 1ETH は何円？
  function ETH_JPY() public view returns (int256) {
    int USD_ETH_price = get_Latest_EU_Price();
    int USD_JPY_price = 10 ** 8 / get_Latest_JU_Price();

    int result = USD_ETH_price * USD_JPY_price;
    return result;
  }
}
