package com.kh.hmm.member.model.service;

import java.io.File;
import java.util.ArrayList;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.hmm.member.model.dao.MemberDao;
import com.kh.hmm.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao mDao;
	@Autowired
	private JavaMailSender javaMailSender;

	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	@Override
	public Member loginMember(Member m) {
		return mDao.loginMember(m);
	}

	@Override
	public Member enrollMember(Member m) {
		return mDao.enrollMember(m);
	}

	@Override
	public Member updateMember(Member m) {
		return mDao.updateMember(m);
	}

	@Override
	public Member dupMember(Member m) {
		// TODO Auto-generated method stub
		return mDao.dupMember(m);
	}

	@Override
	public boolean send(String subject, String text, String from, String to, String filePath) {
		// javax.mail.internet.MimeMessage
		MimeMessage message = javaMailSender.createMimeMessage();

		try {
			// org.springframework.mail.javamail.MimeMessageHelper
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setSubject(subject);
			helper.setText(text, true);
			helper.setFrom(from);
			helper.setTo(to);

			// 첨부 파일 처리
			if (filePath != null) {
				File file = new File(filePath);
				if (file.exists()) {
					helper.addAttachment(file.getName(), new File(filePath));
				}
			}

			javaMailSender.send(message);
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Member emailCheck(Member m) {
		return mDao.emailCheck(m);
	}

	@Override
	public Member updatePhoto(Member m) {
		return mDao.updatePhoto(m);
	}

	@Override
	public Member googleMember(Member m) {
		return mDao.googleMember(m);
	}

	@Override
	public Member checkEmailId(Member m) {
		return mDao.CheckEmailId(m);
	}

	@Override
	public Member selectMember(String writerid)
	{
		return mDao.selectMember(writerid);
	}

	@Override
	public ArrayList<Integer> leveling(long exp)
	{
		return mDao.leveling(exp);
	}

	@Override
	public Integer recompoint(String id)
	{
		return mDao.recompoint(id);
	}

	@Override
	public Integer havmedal(int membercode)
	{
		return mDao.havmedal(membercode);
	}

	@Override
	public void givemedal(int membercode)
	{
		mDao.givemedal(membercode);
	}

	@Override
	public void recomcount5(int membercode)
	{
		mDao.recomcount5(membercode);		
	}

	@Override
	public void recomcount3(int membercode)
	{
		mDao.recomcount3(membercode);
	}
}