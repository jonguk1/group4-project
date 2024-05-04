package com.lend.shareservice.domain.chat;

// 원래 Service가 맞음
// DAO 역할을 하는 ChatRepository
// 하지만 Service 내용과 섞여 있음
// 추후 Service 추가 예정

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
@Slf4j
public class ChatRepository {
    private Map<String, ChatRoomDTO> chatRoomDTOMap;

    @PostConstruct // 의존성 주입이 이루어진 후 초기화 작업이 필요한 메서드에 사용, WAS가 띄워질 때 혹은 Bean이 생성된 후 실행
    private void init()
    {
        chatRoomDTOMap = new LinkedHashMap<>();
    }

    // 전체 채팅방 조회
    public List<ChatRoomDTO> findAllRoom()
    {
        // 채팅방 생성 순서를 최근순으로 반환
        List chatRooms = new ArrayList<>(chatRoomDTOMap.values());
        Collections.reverse(chatRooms);

        return chatRooms;
    }

    // roomID 기준으로 채팅방 찾기
    public ChatRoomDTO findRoomById(String roomId)
    {
        return chatRoomDTOMap.get(roomId);
    }

    // roomName으로 채팅방 만들기
    public ChatRoomDTO createChatRoom(String roomName){
        ChatRoomDTO chatRoom = new ChatRoomDTO().create(roomName); // 채팅룸 이름으로 채팅 룸 생성 후

        // map 에 채팅룸 아이디와 만들어진 채팅룸을 저장장
        chatRoomDTOMap.put(chatRoom.getRoomId(), chatRoom);

        return chatRoom;
    }

    // 채팅방 인원 + 1 이따 수정 **********************************************************************
    public void plusUserCnt(String roomId)
    {
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        room.setUserCount(room.getUserCount() + 1);
    }

    // 채팅방 인원 - 1 이따 수정 **********************************************************************
    public void minusUserCnt(String roomId)
    {
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        room.setUserCount(room.getUserCount() - 1);
    }

    // 채팅방 유저 리스트에 유저 추가
    public String addUser(String roomId, String userName)
    {
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        String userUUID = UUID.randomUUID().toString();

        // 아이디 중복 확인 후 userList에 추가
        room.getUserlist().put(userUUID, userName);

        return userUUID;
    }

    // 채팅방 유저 이름 중복 확인
    public String isDuplicateName(String roomId, String username)
    {
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        String tmp = username;
        
        // 만약 userName이 중복이라면 랜덤한 숫자 붙임
        // 이때 랜덤한 숫자를 붙였을 때 getUserlist 안에 있는 닉네임이라면 다시 랜덤한 숫자 붙이기
        while(room.getUserlist().containsValue(tmp))
        {
            int ranNum = (int)(Math.random() * 100) + 1;
            
            tmp = username + ranNum;
        }
        return tmp;
    }
    
    // 채팅방 유저 리스트 삭제
    public void delUser(String roomId, String userUUID)
    {
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        room.getUserlist().remove(userUUID);
    }
    
    // 채팅방 userName 조회
    public String getUserName(String roomId, String userUUID)
    {
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        return room.getUserlist().get(userUUID);
    }
    
    // 채팅방 전체 userlist 조회
    public ArrayList<String> getUserList(String roomId)
    {
        ArrayList<String> list = new ArrayList<>();
        
        ChatRoomDTO room = chatRoomDTOMap.get(roomId);
        
        // hashmap for문 돌리고 value 값만 뽑아내 list에 저장 후 return
        room.getUserlist().forEach((key, value) -> list.add(value));
        return list;
    }
}
