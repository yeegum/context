package com.sc.exam.dao;

import com.sc.exam.pojo.Note;
import com.sc.exam.pojo.ov.Notes;
import com.sc.exam.pojo.Notetype;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface INoteDao {

    int AddNote(Note note);

    Note existnote(String path);

    List<Note> getNoteByStatus(int sid);

    List<Notetype> getNoteType();

    int changStatus(Note note);

    int delNotesById(List<Integer> idList);

    int changeAllstauts(@Param("list") List<Integer> idList,@Param("sid") int sid);

    int delNoteById(int nid);

    Note getNoteById(int nid);

    int ChangeNoteByNid(Note note);

    List<Notes> getNotes(@Param("sid") int sid,@Param("userid") int userid,@Param("title") String title,@Param("tid") int tid);

    int Addtimes(Note note);

    List<Notes> getHotNotes();
}
