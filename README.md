# Backtesting-Docker-Container

Easy to use Docker Container to backtest trading strategies.
Gives access to three different backtesting frameworks through Jupyter Notebooks.

## Included Frameworks

- [Backtesting.py (🔎📈🐍💰 Backtest trading strategies in Python)](https://github.com/kernc/backtesting.py)
- [Backtrader (A feature-rich Python framework for backtesting and trading)](https://github.com/mementum/backtrader)
- [Fastquant (Backtest and optimize your trading strategies with only 3 lines of code!)](https://github.com/enzoampil/fastquant)

## Examples

### Fastquant
![Example1](https://github.com/enzoampil/fastquant/raw/master/docs/assets/rsi.png)

### backtesting.py
![Example2](https://camo.githubusercontent.com/4f4b375cd80e854082550e1fbcb7ec25ec2156424017474a910789e15c5f7ce0/68747470733a2f2f692e696d6775722e636f6d2f7852464e4866672e706e67)

### Fastquant
![Example1](https://github.com/enzoampil/fastquant/raw/master/docs/assets/bitcoin_forecasts.png)

## Usage

Clone the Github Repository
```bash
git clone https://github.com/timweissenfels/Backtesting-Docker-Container.git
```
Change Path
```bash
cd Backtesting-Docker-Container
```
Build Docker container
```bash
docker build -t quantbase-jupyter .
```
Start Docker container
```bash
docker run -p 8888:8888 --name quantbase-jupyter --rm -itd quantbase-jupyter
```
(If needed) Spawn shell in container
```bash
docker exec -it quantbase-jupyter /bin/bash
```
Navigate to http://{hostname}:8888
Go to New -> Python3

## Documentation for Frameworks
- [Backtrader.py](https://www.backtrader.com/docu/)
- [Backtesting.py](https://kernc.github.io/backtesting.py/doc/backtesting/)
- [Fastquant](https://github.com/enzoampil/fastquant/blob/master/README.md)
