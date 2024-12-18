package com.web.community.converter;

import com.web.community.vo.PlayerVO;

public class PlayerConverter {

    public static PlayerVO convertToPlayerVO(Object[] rawData) {
        PlayerVO player = new PlayerVO();
        
        // rawData의 필드가 다음 순서로 있다고 가정합니다:
        player.setPiNum((int) rawData[0]); // 선수 고유 ID
        player.setPiName((String) rawData[1]); // 선수 이름
        player.setPiDateOfBirth((String) rawData[2]); // 선수 생년월일
        player.setPiNationality((String) rawData[3]); // 선수 국적
        player.setPiPosition((String) rawData[4]); // 선수 포지션
        player.setPiShirtNumber((int) rawData[5]); // 선수 셔츠 번호

        return player; // PlayerVO 객체 반환
    }
}
