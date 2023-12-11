# maps
SUMO에 사용되는 도로 네트워크와 관련된 정보를 담고 있습니다. <\br>
주로 도로의 형상, 연결된 교차로, 차선, 신호등 등의 정보를 포함합니다. <\br>
SUMO 시뮬레이션에서 사용되는 환경을 정의하며, 교통 흐름 및 차량의 이동 경로를 결정합니다.

# 도로 정보
cross -> 왕복 6차선 교차로 <\br>
cross2 -> 왕복 4차선 교차로 <\br>
highway_nomal -> 왕복 6차선 고속도로 <\br>
straight_trafficlight -> 왕복 6차선 신호등 직선도로

# .sumocfg 설정 
<configuration>에서 net-file, route-file의 주소가 정확히 입력되어 있는지 확인해야합니다

