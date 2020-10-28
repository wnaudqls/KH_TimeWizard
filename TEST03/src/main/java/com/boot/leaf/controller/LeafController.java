package com.boot.leaf.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.boot.leaf.dao.ChatRoomRepository;
import com.boot.leaf.dto.ChatRoom;
import com.boot.leaf.dto.ChatRoomForm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequiredArgsConstructor
public class LeafController {

	/*
	 * @GetMapping("/hello") public String Hello(Model model) {
	 * model.addAttribute("name","ㅁㄴㅇㄹ"); return "hello"; }
	 * 
	 * @GetMapping("/utill") public String utill() { return "utill"; }
	 * 
	 * @GetMapping("/express") public String expression(Model model) {
	 * model.addAttribute("name","ThymeLeaf");
	 * 
	 * LeafDto dto = new LeafDto("java", 1); model.addAttribute("dto", dto);
	 * List<LeafDto> list = new ArrayList<LeafDto>(); list.add(new
	 * LeafDto("DataBase", 2)); list.add(new LeafDto("jsp/Servlet", 3));
	 * model.addAttribute("list",list); return "express"; }
	 * 
	 * @GetMapping("/params") public String params(Model model, HttpSession session)
	 * { model.addAttribute("dto", new LeafDto("Spring",4));
	 * session.setAttribute("pw", "qclass"); return "params"; }
	 * 
	 * @GetMapping("/static") public String Static() {
	 * 
	 * return "static"; }
	 */
	
	@Autowired
	private final ChatRoomRepository chatRoomRepository = new ChatRoomRepository();

	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("rooms", chatRoomRepository.findAllRoom());
		return "rooms";
	}

	/*
	 * @GetMapping("/list") public String rooms(Model model) {
	 * model.addAttribute("rooms", chatRoomRepository.findAllRoom()); return
	 * "rooms"; }
	 */
	@GetMapping("/rooms/{id}")
	public String room(@PathVariable String id, Model model) {
		ChatRoom room = chatRoomRepository.findRoomById(id);
		model.addAttribute("room", room);
		return "room";
	}

	@GetMapping("/new")
	public String make(Model model) {
		ChatRoomForm form = new ChatRoomForm();
		model.addAttribute("form", form);
		return "newRoom";
	}

	@PostMapping("/room/new")
	public String makeRoom(ChatRoomForm form) {
		chatRoomRepository.createChatRoom(form.getName());

		return "redirect:/";
	}
}
