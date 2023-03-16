package com.example.volunteertracking.service;

import com.example.volunteertracking.model.Volunteer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Objects;

public class UserDetailsImpl implements UserDetails {
  private static final long serialVersionUID = 1L;

  private int id;

  private String name;

  private String number;

  private String location;

  private String dob;

  private String password;

  private Collection<? extends GrantedAuthority> authorities;

  public UserDetailsImpl(int id, String name, String number, String location,
                         String dob, String password) {
    this.id = id;
    this.name = name;
    this.number = number;
    this.location = location;
    this.dob = dob;
    this.password = password;
  }

  public static UserDetailsImpl build(Volunteer user) {

    return new UserDetailsImpl(
        user.getId(), 
        user.getName(),
        user.getNumber(),
        user.getLocation(),
        user.getDate(), user.getPassword());
  }

  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return authorities;
  }

  @Override
  public String getPassword() {
    return password;
  }

  @Override
  public String getUsername() {
    return name;
  }

  public int getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public String getNumber() {
    return number;
  }

  public String getLocation() {
    return location;
  }

  public String getDob() {
    return dob;
  }

  @Override
  public boolean isAccountNonExpired() {
    return true;
  }

  @Override
  public boolean isAccountNonLocked() {
    return true;
  }

  @Override
  public boolean isCredentialsNonExpired() {
    return true;
  }

  @Override
  public boolean isEnabled() {
    return true;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;
    UserDetailsImpl user = (UserDetailsImpl) o;
    return Objects.equals(id, user.id);
  }
}
